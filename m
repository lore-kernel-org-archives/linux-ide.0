From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Tue, 3 Jan 2006 17:51:57 +0100
Message-ID: <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
References: <20060103164319.GA402@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932431AbWACQwY@vger.kernel.org>
In-Reply-To: <20060103164319.GA402@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 1/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:

> --- a/drivers/scsi/ata_piix.c
> +++ b/drivers/scsi/ata_piix.c

> + * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
> + * for the early chip drivers.

pata_oldpiix and pata_mpiix are not in the mainline
