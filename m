From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RESEND] via82cxxx IDE: Add VT8251 ISA bridge
Date: Thu, 08 Dec 2005 15:42:33 -0500
Message-ID: <43989AB9.60203@pobox.com>
References: <43988D11.80809@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932376AbVLHUmm@vger.kernel.org>
In-Reply-To: <43988D11.80809@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Daniel Drake wrote:
> Some motherboards (such as the Asus P5V800-MX) ship a
> PCI_DEVICE_ID_VIA_82C586_1 IDE controller alongside a VT8251 southbridge.
> 
> This southbridge is currently unrecognised in the via82cxxx IDE driver,
> preventing those users from getting DMA access to disks.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> -- 
> 
> Bart, I submitted this 2 weeks ago but sent it to your old pw.edu.pl 
> address by accident. Sorry about that!

ACK.

VIA sent me the same patch, privately.

	Jeff
