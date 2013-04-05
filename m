From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] [libata] SCSI: really use SATL version in VPD
Date: Fri, 05 Apr 2013 19:24:54 +0400
Message-ID: <515EECC6.9080502@cogentembedded.com>
References: <satl-driver-version-v2> <1365173425-16599-1-git-send-email-baruch@ev-en.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:60692 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132Ab3DEPZy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Apr 2013 11:25:54 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so3896041lbd.10
        for <linux-ide@vger.kernel.org>; Fri, 05 Apr 2013 08:25:53 -0700 (PDT)
In-Reply-To: <1365173425-16599-1-git-send-email-baruch@ev-en.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baruch Even <baruch@ev-en.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

On 05-04-2013 18:50, Baruch Even wrote:

    When you post a new revision of the patch, this should be marked in the 
subject, like this: {PATCH v2].

> As per c78968bb by Jeff Garzik ([libata] SCSI: simulator version, not device version, belongs in VPD)

    Please wrap your lines at 80 characters max.

> We need to provide the SATL driver version and not the disk firmware version
> but the code overwrites the driver version with the disk version.

> Signed-off-by: Baruch Even <baruch@ev-en.org>

WBR, Sergei

