From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sun, 3 Dec 2006 21:32:29 +0100
Message-ID: <c384c5ea0612031232w571caac0sab34e4f1e964d48e@mail.gmail.com>
References: <45715381.80206@SystemDesignWorks.com> <4572D27B.3000909@gmail.com>
	 <457327F4.9040403@SystemDesignWorks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:29036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1760079AbWLCUca (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 15:32:30 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1754976nze
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 12:32:29 -0800 (PST)
In-Reply-To: <457327F4.9040403@SystemDesignWorks.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wayne Sherman <Wayne@systemdesignworks.com>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Wayne,

On 12/3/06, Wayne Sherman <Wayne@systemdesignworks.com> wrote:
> The docs indicate that the Device IDs can change.  They represent the
> mode, not specifically the device.  But when we compare these sources we
> can conclude:
>

Yes, that is exactly what we see; depending on the BIOS setting,
either 0x27c0 or 0x27c1 appears in the PCI identifier.

Also, thanks for correcting me, the Supermicro PDSMI+ indeed has a
ICH7R, not a plain ICH7.

Leon.
