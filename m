From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] [libata] SCSI: really use SATL version in VPD
Date: Fri, 05 Apr 2013 18:44:23 +0400
Message-ID: <515EE347.3040105@cogentembedded.com>
References: <satl-driver-version> <1365162493-9415-1-git-send-email-baruch@ev-en.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:50100 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161744Ab3DEOpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Apr 2013 10:45:23 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so3768718lbd.24
        for <linux-ide@vger.kernel.org>; Fri, 05 Apr 2013 07:45:21 -0700 (PDT)
In-Reply-To: <1365162493-9415-1-git-send-email-baruch@ev-en.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baruch Even <baruch@ev-en.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

On 05-04-2013 15:48, Baruch Even wrote:

> Commit message of c78968bb

    Please also specify the summary line of that commit in parens (or however 
you like).

> by Jeff Garzik says we need to provide the SATL
> driver version and not the disk firmware version but the code overwrites the
> driver version with the disk version.

> Signed-off-by: Baruch Even <baruch@ev-en.org>

WBR, Sergei

