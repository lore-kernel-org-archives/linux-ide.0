From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 0/2] disable trim for SuperSSpeed S238 SSD - v3
Date: Wed, 15 Jul 2015 13:54:35 +0200
Message-ID: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:35109 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbGOLyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 07:54:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org, arne_f@ipfire.org


The SuperSSpeed S238 loose blocks at TRIM so this patchset add
a horkage to disable trim and set it for this disc.
A european distributor (pcengines.ch) has already started
to refund or exchange the discs by a version with disabled TRIM.
http://pcengines.ch/msata16a.htm

V1: - initial patchset
V2: - signed-off commits
    - fix indenting
V3: - better commit messages

--
 drivers/ata/libata-core.c      |  3 +++
 drivers/ata/libata-scsi.c      | 14 ++++++++------
 drivers/ata/libata-transport.c |  2 ++
 include/linux/libata.h         |  2 ++
 4 files changed, 15 insertions(+), 6 deletions(-)
--
