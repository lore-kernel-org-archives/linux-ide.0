From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Mon, 26 Apr 2004 17:02:56 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404261702.57138.bzolnier@elka.pw.edu.pl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040426135058.GC14074@harddisk-recovery.com> <200404261650.40801.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7650 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261724AbUDZPDL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Apr 2004 11:03:11 -0400
In-Reply-To: <200404261650.40801.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Monday 26 of April 2004 16:50, Bartlomiej Zolnierkiewicz wrote:

> I want to rewrite+merge current IDE code with libata during 2.7
> (and yes, legacy naming and ordering will be preserved!).

as a config option not unconditionally

