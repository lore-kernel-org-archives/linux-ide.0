From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: Re: libata-tj and SMART
Date: Tue, 16 May 2006 10:36:59 +0200
Message-ID: <e4c2vb$6rj$1@sea.gmane.org>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:15559 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751682AbWEPIhP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 04:37:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ffv3B-0003Gl-5o
	for linux-ide@vger.kernel.org; Tue, 16 May 2006 10:37:05 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 10:37:05 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 10:37:05 +0200
In-Reply-To: <4469893A.10901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Le 05/16/2006 10:11 AM, Tejun Heo a =E9crit :

> Hmmm.. That measn SMART ENABLE/DISABLE ATTRIBUTE AUTOSAVE command fai=
ls.
>  But weirdly it fails with DRQ (ready for data) bit set, thus trigger=
ing
> HSM violation.  My guess is the drive doesn't support that command an=
d
> when it aborts, it sends funky status.  I think you can safely ignore
> the error or remove -S on from smartd configuration.

Automatic Offline is also failing (-o on):
Error SMART Enable Automatic Offline failed: I/O error
Smartctl: SMART Enable Automatic Offline Failed.

Maybe it's not supported but there was no problem leaving these options
in the past. Anyway removing -o on -S on makes smartd happy.

> If you've got some time though, I'd like to see what's really going o=
n.
>  Can you modify #undef ATA_DEBUT to #define ATA_DEBUG in
> include/linux/libata.h and post the kernel messages after issuing abo=
ve
> command?  Be warned that it will produce a LOT of messages while boot=
ing
> if you're using SATA disks for your system, and it can considerably s=
low
> down booting.

OK.

--=20
Nico
Quand le doigt montre la lune, l'imb=E9cile regarde le doigt.
	-+- Confucius -+-

