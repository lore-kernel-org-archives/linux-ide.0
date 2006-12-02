From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sat, 2 Dec 2006 11:32:01 +0100
Message-ID: <c384c5ea0612020232n3d33cfady627987e98957d495@mail.gmail.com>
References: <45715381.80206@SystemDesignWorks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:58165 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1759420AbWLBKcC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 05:32:02 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1668189nze
        for <linux-ide@vger.kernel.org>; Sat, 02 Dec 2006 02:32:02 -0800 (PST)
In-Reply-To: <45715381.80206@SystemDesignWorks.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wayne Sherman <Wayne@systemdesignworks.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Wayne,

On 12/2/06, Wayne Sherman <Wayne@systemdesignworks.com> wrote:
> Jeff Garzik,
> ...
> my decision on the kernel source code.  It seems to indicate the Intel
> ICH7 is AHCI compatible:
>
We (yesterday) found out that our board (a Supermicro PDSMI+, ICH7 as
well) needs the proper BIOS setting in order for it to appear as a
AHCI capable controller.

Precisely, we found if we enabled "SATA Enhanced Mode", then enabled
"AHCI" in the BIOS, the chipset identifies itself as a 0x27c1 device
rather than a 0x27c0 device.

This is probably exactly the issue you ran into. Try your BIOS settings.

Regards,

Leon Woestenberg.
