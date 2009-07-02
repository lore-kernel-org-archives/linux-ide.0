From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Dump failures
Date: Wed, 01 Jul 2009 21:56:28 -0400
Message-ID: <200907012156.28940.gene.heskett@verizon.net>
References: <200907011021.22540.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:42581 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZGBB4a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 21:56:30 -0400
Received: from coyote.coyote.den ([72.65.71.44]) by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KM400C7STE57N20@vms173011.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 01 Jul 2009 20:56:30 -0500 (CDT)
In-reply-to: <200907011021.22540.gene.heskett@verizon.net>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amanda-users@amanda.org
Cc: linux-ide@vger.kernel.org

On Wednesday 01 July 2009, Gene Heskett wrote:
>Greetings;
>
>I have been getting a failure from amcheckdump since the 28th of June,
>complaining according to a re-run, of the /usr/movies DLE.  du -h . says its
>11 GB, chunk size is set to 2GB, and the tapesize at 40GB.  Seems to me like
>it would fit, but:
>
>Validating image coyote:/usr/movies datestamp 20090701001504 level 0 part 1
> on tape Dailys-9 file #2
>/bin/tar: Unexpected EOF in archive
>/bin/tar: Error is not recoverable: exiting now
>Dump was not successfully validated: Validation process returned 2 (full
>status 512)
>  using '/usr/local/libexec/amanda/application/amgtar validate > /dev/null
> && cat > /dev/null'.
>
>I sic'ed a session of dd piped to tar after it, and it has read a lot more
>than amcheckdump does before it exits, or I used the wrong syntax, possible
>since its been ages since I last did that.
>
>This is 2.6.2, built from the 20090622 snapshot.  kernel 2.6.30, fedora 10
>install.
>
>Ideas anybody?
>
>Thanks.

I know, its considered very poor form to reply to ones own posts, but I have 
another head scratcher to relate.  I have been mounting this partition as a 
plain, no frills ext4 filesystem per recommendations from the kernel folks, 
and I don't believe that I couldn't remount it as ext3 since it was originally 
formatted as ext3.

Consider that this is the virtual tape as written last night:

[root@coyote data]# pwd
/amandatapes/Dailys/data

[root@coyote data]# du -h .
329M    ./Loris-wedding
172K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding017
92K     ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding005
152K    ./Nikis-Wedding/nicciswedding-qdvd/Nikkis-Wedding
132K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding008
156K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding009
140K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding014
140K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding019
164K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding010
124K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding004
148K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding012
164K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding016
116K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding003
132K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding007
156K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding013
60K     ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding018
12K     ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding001
184K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding002
120K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding006
140K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding015
148K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding011
3.0M    ./Nikis-Wedding/nicciswedding-qdvd
12K     ./Nikis-Wedding/nikis-Wedding2
768M    ./Nikis-Wedding/tmp/VIDEO_TS
4.0K    ./Nikis-Wedding/tmp/AUDIO_TS
768M    ./Nikis-Wedding/tmp
6.8G    ./Nikis-Wedding
2.3G    ./emc-at-work
46G     .

46G?  in data/* ?

Somebodies adding machine is broken.  Bug in du -h?  Bug in ext4?

Hummmm, I just unmounted it and remounted it as ext3, and the du -h . results 
are unchanged.  Still 46G.  But the src of that level 0 backup is 11G.

[root@coyote data]# cd /usr/movies
[root@coyote movies]# du -h .
329M    ./Loris-wedding
2.3G    ./emc-at-work
72K     ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding018
168K    ./Nikis-Wedding/nicciswedding-qdvd/Nikkis-Wedding
200K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding002
104K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding005
152K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding014
132K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding006
184K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding017
128K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding003
176K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding016
160K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding011
152K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding015
168K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding013
144K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding008
144K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding007
176K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding010
152K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding019
160K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding012
24K     ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding001
136K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding004
168K    ./Nikis-Wedding/nicciswedding-qdvd/nicci-wedding009
3.3M    ./Nikis-Wedding/nicciswedding-qdvd
20K     ./Nikis-Wedding/nikis-Wedding2
8.0K    ./Nikis-Wedding/tmp/AUDIO_TS
768M    ./Nikis-Wedding/tmp/VIDEO_TS
768M    ./Nikis-Wedding/tmp
6.8G    ./Nikis-Wedding
11G     .

Not 46G.

FWIW, e2fsck 1.41.4 says the device filesystem is clean.

Call me puzzled, but looking for clues.  If anyone has a spare clue I could 
sure use it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The NRA is offering FREE Associate memberships to anyone who wants them.
<https://www.nrahq.org/nrabonus/accept-membership.asp>

Excellent day for putting Slinkies on an escalator.

