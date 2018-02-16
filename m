From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] PATA-MacIO: Adjustments for five function implementations
Date: Fri, 16 Feb 2018 13:37:16 +0100
Message-ID: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:37555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMh3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 16 Feb 2018 07:37:29 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:32:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in two functions
  Adjust 11 checks for null pointers

 drivers/ata/pata_macio.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

-- 
2.16.1

