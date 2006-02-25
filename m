From: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Sat, 25 Feb 2006 17:11:46 +0100
Message-ID: <9a8748490602250811t42629a73o7abbc2cb60a6c8f8@mail.gmail.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <43F2050B.8020006@dgreaves.com>
	 <Pine.LNX.4.64.0602141211350.10793@p34>
	 <200602141300.37118.lkml@rtr.ca>
	 <Pine.LNX.4.64.0602231838420.3374@p34> <44007892.9090002@rtr.ca>
	 <Pine.LNX.4.64.0602251058110.30688@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:35080 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964773AbWBYQLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Feb 2006 11:11:47 -0500
Received: by wproxy.gmail.com with SMTP id i3so830179wra
        for <linux-ide@vger.kernel.org>; Sat, 25 Feb 2006 08:11:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0602251058110.30688@p34>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/25/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

Please don't top-post.

> The kernel is patched, if you did not get what you wanted maybe the patch
> does not work in some instances or there is a bug?
>

You may have patched a kernel source with Mark's patch, but you are
very clearly not running a kernel build from that patched source.

As can be seen from (for example) this bit from Mark's patch

 translate_done:
-       printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
-              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
+       printk(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err
0x%02x/%02x to "
+              "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode,
drv_stat, drv_err,
              *sk, *asc, *ascq);

the patch changes the text being printed. In this case the text
"ata%u: translated ATA stat/err ..." is changed into "ata%u:
translated ATA stat/err ..."

And if we look at the output you posted :

> >> Here it is:
> >>
> >> [263864.109854] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
> >> 0xb/00/00

That string is clearly from an un-patched kernel as Mark also pointed
out in his reply to you.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
