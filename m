From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/2] libata: Return of the ACPI Patches
Date: Wed, 27 Sep 2006 15:36:19 -0700
Message-ID: <20060927153619.b4126a63.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14683 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031163AbWI0WgT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Sep 2006 18:36:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net, jgarzik@pobox.com

Hello,
These are patches that use ACPI to help reinitialize SATA drivers
on resume.  They were created and first submitted by Randy Dunlap last
year, and then again by Forrest Zhao a couple months ago.  And now it's
my turn.  These are against 2.6.18-mm1 - please let me know if you want
me to patch against a different code base.  Hopefully I've captured all
the past feedback, but sorry in advance if I've missed something that's
been said before.

Thanks,
Kristen

--
