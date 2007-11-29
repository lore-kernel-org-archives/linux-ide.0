From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 15:59:56 +0000
Message-ID: <20071129155956.4004ca89@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468192463-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58287 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761340AbXK2QFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:05:13 -0500
In-Reply-To: <11963468192463-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>, Albert Lee <albertcc@tw.ibm.com>

> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).

Why 16 not 64K ?

Please add a comment to note that the drivers assume
- drain is only ever done on a stuck PIO xfer
- drain occurs before any controller error/reset handling is done
