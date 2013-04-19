From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: ahci driver cannot suspend a CF card, ata_piix can
Date: Fri, 19 Apr 2013 23:14:36 +0800
Message-ID: <51715F5C.3050502@gmail.com>
References: <516D3CEF.6010202@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <516D3CEF.6010202@pr.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 04/16/2013 07:58 PM, Boszormenyi Zoltan wrote:
> Hi,
>
> The SATA interface can be switched between AHCI and legacy modes as usual:
>
> 00:1f.2 SATA controller: Intel Corporation NM10/ICH7 Family SATA
> Controller [AHCI mode] (rev 02)
>
> The device attached to the SATA controller is always a CF card via a
> SiI3811 Serial ATA to Parallel ATA Device Bridge based converter board.

Can you please attach a normal sata disk and try again with the
controller set to AHCI mode? I suspect it may be the SiI3811 bridge that
caused this command.

Thanks,
Aaron
