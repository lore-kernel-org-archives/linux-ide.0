From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: libata-tj and SMART
Date: Tue, 16 May 2006 00:41:32 +0200
Message-ID: <e4b02t$e9b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:61882 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965277AbWEOWlo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 18:41:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fflky-0001fR-IF
	for linux-ide@vger.kernel.org; Tue, 16 May 2006 00:41:40 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 00:41:40 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 00:41:40 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've been using libata-tj for a couple of days and for now it's working
without problem, my SI-3112 is finally working :) Thanks !

I've noticed these errors while trying to issue some SMART commands to
the SATA drive :

> May 16 00:28:33 aneto kernel: ata3: soft resetting port
> May 16 00:28:33 aneto kernel: ata3: SATA link up 1.5 Gbps (SStatus 11=
3 SControl 310)
> May 16 00:28:33 aneto kernel: ata3.00: configured for UDMA/100
> May 16 00:28:33 aneto kernel: ata3: EH complete
> May 16 00:28:33 aneto kernel: ata3.00: exception Emask 0x0 SAct 0x0 S=
Err 0x0 action 0x1 frozen
> May 16 00:28:33 aneto kernel: ata3.00: tag 0 cmd 0xb0 Emask 0x2 stat =
0x51 err 0x4 (HSM violation)
> May 16 00:28:33 aneto kernel: ata3.00: failed to IDENTIFY (I/O error,=
 err_mask=3D0x40)
> May 16 00:28:33 aneto kernel: ata3.00: revalidation failed (errno=3D-=
5)
> May 16 00:28:33 aneto kernel: ata3: failed to recover some devices, r=
etrying in 5 secs
> May 16 00:28:39 aneto kernel: ata3: soft resetting port
> May 16 00:28:39 aneto kernel: ata3: SATA link up 1.5 Gbps (SStatus 11=
3 SControl 310)
> May 16 00:28:39 aneto kernel: ata3.00: configured for UDMA/100
> May 16 00:28:39 aneto kernel: ata3: EH complete

smartd then entered in a "D" state for some time.

Please feel free to ask for any relevant additional information...

Regards,
--=20
Nico
Avant donc que d'=E9crire, apprenez =E0 penser.
	-+- Nicolas Boileau, Art po=E9tique -+-

