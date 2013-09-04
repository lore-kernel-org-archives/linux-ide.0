From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/4] AHCI: Conserve interrupts with
 pci_enable_msi_block_part() interface
Date: Wed, 4 Sep 2013 10:57:43 -0400
Message-ID: <20130904145743.GC25788@mtj.dyndns.org>
References: <cover.1378111919.git.agordeev@redhat.com>
 <20130903135541.GB10522@htj.dyndns.org>
 <20130903140954.GC10522@htj.dyndns.org>
 <20130904123238.GC8726@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130904123238.GC8726@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Sep 04, 2013 at 02:32:39PM +0200, Alexander Gordeev wrote:
> Hmm.. that is actually a great idea. What I am not sure about whether is
> a dummy port still can send (spurious?) interrupts? The hardware interrupt
> handler would have to be reworked then. Seems as a yet another topic to me ;)

Only unimplemented ports are assigned to be dummies and it's highly
unlikely that they'll generate spurious interrupts.  That said, I
think it'd be a good idea to be ready for that if that doesn't add too
much complexity / overhead.

Thanks.

-- 
tejun
