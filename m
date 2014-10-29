From: "Jason B. Akers" <jason.b.akers@intel.com>
Subject: [RFC PATCH] sg3_utils Hybrid Information Log utility
Date: Wed, 29 Oct 2014 12:57:15 -0700
Message-ID: <20141029195400.5225.96984.stgit@stg-AndroidDev-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8148 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbaJ2UJu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Oct 2014 16:09:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: dan.j.williams@intel.com, kapil.karkra@intel.com, linux-kernel@vger.kernel.org, dgilbert@interlog.com

The following series implements a sg_sat_get_hybrid_log utility allowing users to view the SSHD Hybrid Information Log as defined in the SATA 3.2 standard.

---

Kapil Karkra (1):
      sg3_utils: Added hybrid information log utility


 src/Makefile.am             |   21 ++
 src/sg_sat_get_hybrid_log.c |  419 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 434 insertions(+), 6 deletions(-)
 create mode 100644 src/sg_sat_get_hybrid_log.c

--
Thanks,
jba
