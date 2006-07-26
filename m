From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ahci: updated power management support
Date: Wed, 26 Jul 2006 15:59:25 +0900
Message-ID: <11538971651205-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:62052 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030441AbWGZG7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:31 -0400
Received: by py-out-1112.google.com with SMTP id t32so3362771pyc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 23:59:31 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is updated version of AHCI power management patchset[1] from
Forrest Zhao.  A lot of implementation is taken verbatim but code has
been simplified and reorganized.

Major changes are...

* Initialization functions are best-effort.  They don't check for
  prerequisites.  This is for both simplicity & robustness and
  simplifies code a lot.  More explanation on this in patch #3.

* Both port suspend/resume() and pci_device suspend/resume() share
  most of code with driver init/de-init paths as other drivers do.

* Patches are splitted according to logical steps instead of define X
  / use X.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/12210


