From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Wed, 25 Nov 2009 12:19:49 -0500
Message-ID: <4B0D6735.8000604@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934855AbZKYRTy@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/25/2009 12:02 PM, Bartlomiej Zolnierkiewicz wrote:
> I've been going through PATA drivers for the last few days to make
> sure that we offer similar level of hardware support in the new PATA
> drivers as with the old IDE subsystem and the following patchset is
> the end result of said audit.

Thanks!

> - add 32-bit PIO support for more controllers
>
>    ( pata_artop, pata_atiixp, pata_efar, pata_cmd64x, pata_cs5520,
>      pata_cs5530, pata_cs5535, pata_cypress, pata_hpt366, pata_hpt37x,
>      pata_hpt3x2n, pata_it8213, pata_it821x, pata_jmicron, pata_ns87415,
>      pata_opti, pata_pdc2027x, pata_pdc202xx_old, pata_rz1000,
>      pata_sc1200, pata_scc, pata_sch, pata_serverworks, pata_sl82c105,
>      pata_sis, pata_triflex&  pata_via )

This should be all in one patch.

I'll let the comments from Alan and others trickle in before applying...

> - add ->init_host method for abstracting host specific controller
>   initialization and then use it to cleanup Power Managment code
>   resulting in over 100 LOC gone
>
>   ( pata_ali, pata_amd, pata_artop, pata_cmd640, pata_cmd64x,
>     pata_cs5530, pata_hpt366, pata_hpt3x3, pata_it821x, pata_ninja32,
>     pata_ns87415, pata_pdc2027x & sata_sil )

hmmmm....  will reserve comment until I review it thoroughly, but I am a 
bit reluctant to move away from the current struct-driver style driver 
init/setup model.

	Jeff
