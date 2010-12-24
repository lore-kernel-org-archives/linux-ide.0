From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: no special completion processing
 for EH commands
Date: Fri, 24 Dec 2010 13:39:03 -0500
Message-ID: <4D14E8C7.9030101@garzik.org>
References: <4D00EED4.3020901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41605 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0LXSjG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:39:06 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so7308182qwa.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 10:39:06 -0800 (PST)
In-Reply-To: <4D00EED4.3020901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kyle McMartin <kyle@mcmartin.ca>, stable@kernel.org

On 12/09/2010 09:59 AM, Tejun Heo wrote:
> ata_qc_complete() contains special handling for certain commands.  For
> example, it schedules EH for device revalidation after certain
> configurations are changed.  These shouldn't be applied to EH
> commands but they were.
>
> In most cases, it doesn't cause an actual problem because EH doesn't
> issue any command which would trigger special handling; however, ACPI
> can issue such commands via _GTF which can cause weird interactions.
>
> Restructure ata_qc_complete() such that EH commands are always passed
> on to __ata_qc_complete().
>
> stable: Please apply to -stable only after 2.6.38 is released.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Kyle McMartin<kyle@mcmartin.ca>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-core.c |   24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

applied


