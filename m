From: tho@doma.ballum.wikaba.com
Subject: kernel panic in ide_init_queue (if tagged command queueing
	is configured)
Date: Wed, 20 Nov 2002 15:35:37 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E18EeNd-0007ni-00@doma.ballum>
Reply-To: gthomsen@sbcglobal.net
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from localhost
	([127.0.0.1] helo=doma.ballum.wikaba.com ident=foobar)
	by doma.ballum with esmtp (Exim 3.35 #1 (Debian))
	id 18EeNd-0007ni-00
	for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2002 15:35:37 -0800
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

the 2.5.4x (for x in {4,7,8} verified) panics in ide_init_queue on my
IBM ThinkPad X21 (2662XXK) with 20GB TravelStar (IC25N020ATCS04-0) if
 CONFIG_BLK_DEV_IDE_TCQ is set.

Should the laptop/harddisk on a blacklist or is that feature _that_
experimental?

Please let me know, if I can provide more information to help solve
this issue (which is minor, _if_ it is documented).

cheers
    Guenther

PS: Please e-mail me directly, as I do not frequent this list.
PS2: Oops, I almost sent the System map, but that beast is 0.5MB
uncompressed. I'm sure not everyone on the list wants that ;-}

#text/plain; name="2.5.47-panic" [reg dump / stack trace] /home/tho/2.5.47-panic

