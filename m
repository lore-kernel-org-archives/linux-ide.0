From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] pata_pdc2027x: Remove unnecessary error check
Date: Tue, 05 Dec 2017 14:59:44 +0100
Message-ID: <3041820.Z4NqBeWCEa@amdc3058>
References: <CGME20171125102004epcas1p37d88a9f8b55c84e6573a0f11443a6d56@epcas1p3.samsung.com>
        <a6bc518e67419242f1409206972590c22f34ba5b.1511604820.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47244 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbdLEN7e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Dec 2017 08:59:34 -0500
In-reply-to: <a6bc518e67419242f1409206972590c22f34ba5b.1511604820.git.arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday, November 25, 2017 03:49:49 PM Arvind Yadav wrote:
> Here, The function pdc_hardware_init always return zero. So it is not
> necessary to check its return value.

Please fix pdc_adjust_pll() to return the error value instead.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

