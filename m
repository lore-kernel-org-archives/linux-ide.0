From: Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 12:14:54 -0700
Message-ID: <20051029121454.5d27aecb.akpm@osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932115AbVJ2TPb@vger.kernel.org>
In-Reply-To: <20051029182228.GA14495@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Please pull from 'upstream-linus' branch of
>  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
>  to obtain misc fixes and cleanups, and to merge
>  the ATA passthru (SMART support) feature.

Are you sure this doesn't propagate Max Kellermann's "2.6.14-rc4-mm1 and
later: second ata_piix controller is invisible" regression?

He did confirm that git-libata-all.patch caused it.
