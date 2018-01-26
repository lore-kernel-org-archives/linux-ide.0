From: James Bottomley <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH resend 0/6] Fix cdrom autoclose
Date: Fri, 26 Jan 2018 12:04:56 -0800
Message-ID: <1516997096.3034.10.camel@linux.vnet.ibm.com>
References: <cover.1513263482.git.msuchanek@suse.de>
         <cover.1516985620.git.msuchanek@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbeAZUFW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2018 15:05:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0QK5GTr102314
        for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2018 15:05:21 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fr5u84kns-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2018 15:05:17 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ide@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Fri, 26 Jan 2018 15:05:07 -0500
In-Reply-To: <cover.1516985620.git.msuchanek@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Suchanek <msuchanek@suse.de>, Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>, Tim Waugh <tim@cyberelk.net>, "David S. Miller" <davem@davemloft.net>, "Martin K. Petersen" <martin.petersen@oracle.com>, Kees Cook <keescook@chromium.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, 2018-01-26 at 17:58 +0100, Michal Suchanek wrote:
> First time I did not get any feedback for the patches.

This is likely because no-one who might inspect the code saw the
patches ... what list are they going to?  I'm on the block, scsi and
ide mailing lists and I only saw a doc patch the last time.

James

