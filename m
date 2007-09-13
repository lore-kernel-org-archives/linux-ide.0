From: Jeff Garzik <jeff@garzik.org>
Subject: Re: HDIO_DRIVE_TASKFILE not supported in libata ?
Date: Thu, 13 Sep 2007 18:31:21 -0400
Message-ID: <46E9BA39.7000705@garzik.org>
References: <348832.98955.qm@web35402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44309 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbXIMWbY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 18:31:24 -0400
In-Reply-To: <348832.98955.qm@web35402.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kantor Zsolt <kantorzsolt@yahoo.com>
Cc: linux-ide@vger.kernel.org

Kantor Zsolt wrote:
> HDIO_DRIVE_TASKFILE is not supported in libata ? and if not then which was the last version of
> libata that supported the HDIO_DRIVE_TASKFILE command in which kernel ?

libata has never supported HDIO_DRIVE_TASKFILE.

You want to use SG_IO.

	Jeff



