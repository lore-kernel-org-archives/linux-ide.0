From: Brian King <brking@us.ibm.com>
Subject: [PATCH 0/2] ipr: Support SATA devices
Date: Wed, 07 Jun 2006 11:28:05 -0500
Message-ID: <4486FE95.6080605@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35209 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932315AbWFGQ2I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2006 12:28:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 'SCSI Mailing List' <linux-scsi@vger.kernel.org>, James Bottomley <James.Bottomley@steeleye.com>

The following patchset adds support to ipr to attach SATA
devices using the new libata interfaces in my previous patchset.

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
