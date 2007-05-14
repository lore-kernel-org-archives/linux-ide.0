From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATA ACPI support, take#3
Date: Tue, 15 May 2007 03:28:15 +0900
Message-ID: <11791672953697-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:28140 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXENS2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 14:28:22 -0400
Received: by py-out-1112.google.com with SMTP id a29so1596372pyi
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 11:28:21 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the third take of improve-ata-acpi.  Except for regeneration
to fit the current libata-dev#upstream[U], there's no change from
the last take[L].

Jeff, the first two fixes possible problem when HPA is used.  I think
these two should go into 2.6.22.

Thanks.

--
tejun

[U] b9a3b4d1453689f2927668fcdc4827fdccf44d1b
[L] http://thread.gmane.org/gmane.linux.acpi.devel/22819

