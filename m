From: "David Ellingsworth" <david@identd.dyndns.org>
Subject: Re: Promise PDC20376
Date: Mon, 1 Dec 2008 20:43:38 -0500
Message-ID: <30353c3d0812011743we0bdddk2c9c37dd0191cf2a@mail.gmail.com>
References: <30353c3d0810240704n7476cc50y28b3eb8a5f326626@mail.gmail.com>
	 <30353c3d0811250616o733fb7f9ob4af96dd604f78ea@mail.gmail.com>
	 <18732.3809.720247.329641@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:13602 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYLBBnk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Dec 2008 20:43:40 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2870787ugf.37
        for <linux-ide@vger.kernel.org>; Mon, 01 Dec 2008 17:43:38 -0800 (PST)
In-Reply-To: <18732.3809.720247.329641@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>  > Since I put this out there, I felt it was important to follow-up on so
>  > others could benefit from my experiences. After extensive testing, the
>  > cause of the problems I've experienced are a result of a bug in the
>  > Fasttrak bios for the Promise 376 controller. Specifically speaking,
>  > bios interrupt 13h, AH=42 fails to read the requested sector from the
>  > drive despite the fact that bios interrupt 13h, AH=41, BX=0x55AA
>  > indicates the drive supports LBA extensions. The only known
>  > work-around at this time is to limit the size of the primary boot
>  > partition to 8GB or less and place it below the 8GB boundary where LBA
>  > extensions are not required to read the drive. I have contacted
>  > Promise concerning this issue and will provide more updates if
>  > anything metabolizes. Until then any users experiencing similar issues
>  > should use the work-around I've described above to boot the operating
>  > system of their choice.
>
> For booting with grub only /boot needs to be accessible by the BIOS,
> so it's common to make /boot a separate partition early on the disk
> with / and other partitions higher up.
>
> This is the first I've heard of any Promise SATA controller having
> such lame limitations.
>

A small update to this. It seems the above mentioned interrupt fails
somewhere around the 128GB boundary. Interrupt 13h, AH=42 uses a 64
bit sector address and should be capable of addressing the entire
drive. For a SATA controller, this limitation seems relatively
arbitrary. For IDE controllers, a limitation such as this is
apparently common.

Regards,

David Ellingsworth
