From: Tejun Heo <htejun@gmail.com>
Subject: Re: HDIO_DRIVE_TASKFILE not supported in libata ?
Date: Sun, 16 Sep 2007 14:18:20 +0200
Message-ID: <46ED1F0C.6020101@gmail.com>
References: <348832.98955.qm@web35402.mail.mud.yahoo.com> <46E9BA39.7000705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:33091 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXIPMUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 08:20:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1048151rvb
        for <linux-ide@vger.kernel.org>; Sun, 16 Sep 2007 05:20:10 -0700 (PDT)
In-Reply-To: <46E9BA39.7000705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kantor Zsolt <kantorzsolt@yahoo.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Kantor Zsolt wrote:
>> HDIO_DRIVE_TASKFILE is not supported in libata ? and if not then which
>> was the last version of
>> libata that supported the HDIO_DRIVE_TASKFILE command in which kernel ?
> 
> libata has never supported HDIO_DRIVE_TASKFILE.

&& it won't.  The TASKFILE interface is pretty broken and had several
behavior idiosynchronicities (Documentataion/ioctl/hdio.txt).  IDE ->
libata transition is pretty good chance to kill it.

-- 
tejun
