From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH RFC 0/12] ahci: Add support for non-PCI devices
Date: Tue, 2 Mar 2010 21:28:50 +0300
Message-ID: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi all,

This patch set refactors AHCI code to make it more generic, plus
adds a new platform driver to support AHCI interfaces integrated
into System-On-Chip devices.

The patches should apply on top of v2.6.33 (soon will be rebased
on top of linux-next).

I don't have any PCI AHCI handy (yet, but I plan to find one), so
PCI AHCI was only compile-tested.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
