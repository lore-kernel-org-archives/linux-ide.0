From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: improve failed qc reporting
Date: Tue, 14 Nov 2006 14:26:42 -0500
Message-ID: <455A1872.7070102@pobox.com>
References: <20061114133612.GC27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37833 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966288AbWKNT0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 14:26:44 -0500
In-Reply-To: <20061114133612.GC27684@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Improve failed qc reporting.  The original message didn't include the
> actual command nor full error status and it was necessary to
> temporarily patch the code to find out exactly which command is
> causing problem.  This patch makes EH report full command and result
> TFs along with data direction and length.  This change will make bug
> reports more useful.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


