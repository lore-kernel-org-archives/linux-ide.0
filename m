From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH v2] ahci: compile out msi/msix infrastructure
Date: Mon, 07 Dec 2015 10:53:10 +0100
Message-ID: <87fuzepou1.fsf@dell.be.48ers.dk>
References: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38670 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbbLGJxM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2015 04:53:12 -0500
Received: by wmec201 with SMTP id c201so143189010wme.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2015 01:53:11 -0800 (PST)
In-Reply-To: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
	(Dan Williams's message of "Sat, 05 Dec 2015 16:18:44 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: tj@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

>>>>> "Dan" == Dan Williams <dan.j.williams@intel.com> writes:

 > Quoting Arnd:
 >     The AHCI driver is used for some on-chip devices that do not use PCI
 >     for probing, and it can be built even when CONFIG_PCI is disabled, but
 >     that now results in a build failure:

 >     ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
 >     ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
 >     ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'

 > Add ifdef CONFIG_PCI_MSI infrastructure to compile out the mutli-msi and

s/mutli/multi/

-- 
Bye, Peter Korsgaard
