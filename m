From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] libata fixes for v4.9-rc2
Date: Wed, 26 Oct 2016 23:17:10 +0100
Message-ID: <18892.1477520230@warthog.procyon.org.uk>
References: <20161026182911.GB23927@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026182911.GB23927@htj.duckdns.org>
Content-ID: <18891.1477520230.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, hch@lst.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> The AHCI MSI handling change in rc1 was a bit broken and caused disk
> probing failures on some machines.  These three patches should fix the
> issues.

My test machine fell foul of this using a PCIe M.2-attached SSD card.
The patches fix it for me.

Tested-by: David Howells <dhowells@redhat.com>
