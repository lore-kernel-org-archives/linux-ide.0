From: Tejun Heo <tj@kernel.org>
Subject: Re: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag
 them as removable" changes userspace behavior
Date: Thu, 25 Feb 2016 16:20:00 -0500
Message-ID: <20160225212000.GC6092@mtj.duckdns.org>
References: <56CF35FA.1070500@redhat.com>
 <CAOLZvyEheaW128Yw7MNqZHjOERry0-v=46kXKbazNE3Oha=-Mw@mail.gmail.com>
 <56CF57E5.7040808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CF57E5.7040808@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Linux-IDE <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello, Laura.

On Thu, Feb 25, 2016 at 11:37:09AM -0800, Laura Abbott wrote:
> The mounting comes from udisks. udisks will automount anything marked as removable
> unless explicitly forbidden. You can argue whether or not this is good design but
> it's still a change in behavior from what udisks was relying on to decide
> whether or not to automount. lspci from the users hardware:
> 
> 00:1f.2 SATA controller: Intel Corporation C600/X79 series chipset 6-Port SATA
> AHCI Controller (rev 06)

It is a behavior change but difficult to characterize as a breakage,
given that we do want userland to treat ports explicitly marked as
external to be treated as such.  That said, eSATA being mostly a
fringe thing, we can go "whatever" and revert it.

Let's hope it's a false positive that the patch can fix.

Thanks.

-- 
tejun
