From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/3] Resend: Libata delay patches
Date: Wed, 05 May 2010 10:24:42 +0100
Message-ID: <20100505092350.586.46344.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39728 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342Ab0EEKDQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 06:03:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox (3):
      libata: Make sil680 do its own exec_command posting
      libata: Remove excess command issue delays
      libata: Remove excess delay in the tf_load path

