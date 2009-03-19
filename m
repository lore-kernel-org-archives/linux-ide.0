From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: Blacklist HP Compaq 6720s that spins off disks
 during ACPI power off
Date: Fri, 20 Mar 2009 08:11:34 +0900
Message-ID: <49C2D126.3050807@gmail.com>
References: <200903200006.46859.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:31827 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbZCSXLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2009 19:11:46 -0400
In-Reply-To: <200903200006.46859.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>

Rafael J. Wysocki wrote:
> From: Maciej Rutecki <maciej.rutecki@gmail.com>
> 
> Blacklist HP Compaq 6720s so that it doesn't play a "spin down,
> spin up, spin down" ping-pong with the hard disk during system
> power off.
> 
> Signed-off-by: Maciej Rutecki <maciej.rutecki@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
