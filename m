From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
 DMA_NONE
Date: Mon, 11 Dec 2006 23:23:35 +0900
Message-ID: <457D69E7.9040708@gmail.com>
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:28039 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934422AbWLKOXo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 09:23:44 -0500
Received: by nz-out-0102.google.com with SMTP id s1so793409nze
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 06:23:44 -0800 (PST)
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> I'll follow up with conversion to ata_do_simple_cmd().

The current situation is...

ata_exec_internal_sg()	: no user except for ata_exec_internal() yet
ata_exec_internal()	: one data transferring user. other are non-data
ata_do_simple_cmd()	: three users

So, adding another exec_internal variant doesn't look so hot.  It seems
we already have enough variants considering the small number of users.
I think it's best to leave it alone for now.

Thanks.

-- 
tejun
