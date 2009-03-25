From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: Blacklist HP Compaq 6720s that spins off disks
 during ACPI power off
Date: Tue, 24 Mar 2009 22:14:36 -0400
Message-ID: <49C9938C.9000700@garzik.org>
References: <200903200006.46859.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48860 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbZCYCOo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:14:44 -0400
In-Reply-To: <200903200006.46859.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>

Rafael J. Wysocki wrote:
> From: Maciej Rutecki <maciej.rutecki@gmail.com>
> 
> Blacklist HP Compaq 6720s so that it doesn't play a "spin down,
> spin up, spin down" ping-pong with the hard disk during system
> power off.
> 
> Signed-off-by: Maciej Rutecki <maciej.rutecki@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

applied


