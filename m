From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement new initialization model, take #3
Date: Fri, 9 Mar 2007 20:15:35 +0900
Message-ID: <1173438935540-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:50781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767177AbXCILPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:15:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so740598nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 03:15:34 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of new init model.  Previously, libata LLDs
should have filled probe_ent with appropriate info and pass it to
ata_device_add() which will allocate and initialize ata_host
accordingly, request IRQs and attache the host.

The problem with the previous approach was that the info which can be
passed via probe_ent is inflexible.  This made init path of peculiar
controllers twisted.  For example, sata_promise and sata_via support
heterogeneous configuration where PATA and SATA ports reside on the
same host.  As probe_ent couldn't carry this information to
ata_device_add(), those controllers had to override stuff in
->port_start() and add branches in various places.

New init model is a bit more conventional than the old one.  It
follows the good old allocate-init-attach model.  A LLD allocates a
host populated with the specified number of ports, initializes the
host as it wishes and tell libata to attach the initialized host.  So,
LLDs can intialize the host anyway it wants to.

Helpers to do a series of things in one go are provided such that
simple/common initialization can be performed easily.  Requesting IRQ
is now LLD's responsibility and libata knows nothing about it (except
in activation helper).  This nicely allows MSIX support if ever
needed.

This patchset increases code in libata core layer but makes LLDs
simpler.  For details, please read description in each patch.

As devres is now in place, libata core layer can offload resource
management to it.  This makes this take very different and much
simpler than the last take[L].  As it's a vastly different
implementation, detailed change list isn't very meaningful and
thus omitted.

This patchset is against...

libata-dev#upstream (bbaa9bb11c6854781ac13c64954f42bc0e067c09)
+ [1] libata-fix-ata_host_release-free-order
+ [2] libata-fix-native-mode-disabled-port-handling
+ [3] iomap-implement-pcim-iounmap-regions
+ [4] ahci-separate-port-number-determination-from-host-initialization

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/12741
[1] http://article.gmane.org/gmane.linux.ide/16802
[2] http://article.gmane.org/gmane.linux.ide/16804
[3] http://article.gmane.org/gmane.linux.ide/16805
[4] http://article.gmane.org/gmane.linux.ide/16806


