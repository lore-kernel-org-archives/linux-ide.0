From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] IDE-ACPI: Fine-tuning for a function
Date: Sat, 26 Dec 2015 11:10:33 +0100
Message-ID: <567E6799.5070802@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 11:04:56 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  One function call less in ide_get_dev_handle() after error detection
  Delete unnecessary null pointer checks in ide_get_dev_handle()
  Move an assignment for one variable in ide_get_dev_handle()

 drivers/ide/ide-acpi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.6.3

