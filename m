From: "Andrei Tanas" <andrei@tanas.ca>
Subject: RE: MD/RAID: what's wrong with sector 1953519935?
Date: Wed, 26 Aug 2009 21:37:21 -0400
Message-ID: <000001ca26b6$ecb2e1d0$c618a570$@ca>
References: <004e01ca25e4$c11a54e0$434efea0$@ca>    <9cfb6af689a7010df166fdebb1ef516b.squirrel@neil.brown.name>    <4A948A82.4080901@redhat.com> <b585ed9f13649050bbc984869d081315.squirrel@neil.brown.name> <4A94905F.7050705@redhat.com> <005101ca25f4$09006830$1b013890$@ca> <4A94A0E6.4020401@redhat.com> <005401ca25ff$9ac91cc0$d05b5640$@ca> <4A950FA6.4020408@redhat.com> <92cb16daad8278b0aa98125b9e1d057a@localhost> <4A95573A.6090404@redhat.com> <1571f45804875514762f60c0097171e6@localhost> <4A95CE31.80404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tanas.ca ([206.248.136.31]:59288 "EHLO tanas.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbZH0BhP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 21:37:15 -0400
In-Reply-To: <4A95CE31.80404@rtr.ca>
Content-Language: en-ca
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: 'Ric Wheeler' <rwheeler@redhat.com>, 'NeilBrown' <neilb@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> I suggest you try this:
> 
>     hdparm --read-sector 1953519935 /dev/sdb
> 
> If that succeeds, then the sector is good at the drive.

It succeeds.

> But *If* it fails, then you could check the syslog to ensure
> that it didn't fail for some weird reason, and then *fix* it:
> 
>     hdparm --write-sector 1953519935 /dev/sdb
> 
> This is very different from how 'dd' does writes.

The drive never did report any media errors. It just mysteriously times out once in every few hundred hours while writing the raid superblock in that sector.


