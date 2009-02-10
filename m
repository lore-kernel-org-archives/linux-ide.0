From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] ide: add ->dma_expiry method and remove ->dma_exec_cmd
 one
Date: Tue, 10 Feb 2009 21:18:27 +0300
Message-ID: <4991C4F3.2040404@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209232012.32406.88338.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47083 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753851AbZBJSSJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 13:18:09 -0500
In-Reply-To: <20090209232012.32406.88338.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Rename dma_timer_expiry() to ide_dma_sff_expiry() and export it.

> * Add ->dma_expiry method

    This name doesn't seem to make much sense. Why not leave it dma_timer_expiry?

MBR, Sergei
