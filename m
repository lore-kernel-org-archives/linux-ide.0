From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2.6.11-rc3 06/11] ide: make disk flush functions
  use TASKFILE instead
Date: Fri, 11 Feb 2005 20:55:15 -0500
Message-ID: <200502112058_MC3-1-95CC-5FF0@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from siaag1ae.compuserve.com ([149.174.40.7]:2440 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262179AbVBLB7X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Feb 2005 20:59:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 10 Feb 2005 at 17:38:39 +0900, Tejun Heo wrote:

> -         (drive->capacity64 >= (1UL << 28)))
> -             rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> +         (drive->capacity64 >= (1UL << 28))) {
> +             task->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;


  Shouldn't that be "(drive->capacity64 > (1UL << 28))" ??

--
Chuck
