From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET] dmraid: use alt_size
Date: Sun, 01 Feb 2009 11:59:30 +0900
Message-ID: <49851012.8070904@kernel.org>
References: <1233456951-992-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60241 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZBADAD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 22:00:03 -0500
In-Reply-To: <1233456951-992-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com, Mauelshagen@RedHat.c

Hello again,

This patchset is for dmraid-1.0.0.rc15 and NOT for kernel.  It
contains the following three patches to make dmraid use alt_size if
available.

  0001-dmraid-set-read_info-to-offset-by-default-in-read_.patch
  0002-dmraid-add-alt_size-to-dev_info.patch
  0003-dmraid-make-nv-use-alt_size-if-available.patch

Thanks.

-- 
tejun
