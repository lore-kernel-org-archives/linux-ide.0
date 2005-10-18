From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Tue, 18 Oct 2005 16:56:05 -0400
Message-ID: <43556165.1080307@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org>	<Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>	<4353C42A.3000005@pobox.com>	<Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>	<4353CF7E.1090404@pobox.com>	<Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>	<4353D905.3080400@pobox.com> <20051018151526.5f4deef6.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751500AbVJRU4Q@vger.kernel.org>
In-Reply-To: <20051018151526.5f4deef6.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

Sergey Vlasov wrote:
> The IDE=y part seems to be incorrect - quirk_intel_ide_combined() is
> needed even with modular IDE.  Without this quirk you will get one of
> these configurations depending on the module load order:
> 
> 1) ata_piix loads first - it grabs the whole controller, including the
> PATA port; the IDE module loaded later finds nothing.
> 
> 2) IDE modules are loaded first - without the quirk IDE drivers will
> grab the whole controller, including the SATA part.
> 
> The binding you get with builtin IDE (ata_piix/ahci for SATA, generic
> IDE driver for PATA) would be impossible to get with modular IDE without
> the quirk, which does not seem to be good...

This is a reasonable point, but the rare person who runs modular IDE on 
these PATA/SATA combined mode beasts can certainly tell the IDE driver 
to not probe certain ports.

	Jeff
