From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 07:05:38 -0700
Message-ID: <466D56B2.5080109@linux.intel.com>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:25484 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbXFKOHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 10:07:14 -0400
In-Reply-To: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Fremlin <john@fremlin.org>
Cc: linux-ide@vger.kernel.org, power@bughost.org

> This is very different from the patch I posted a while ago turning on
> a few bits in the CMD register (ALPE and ASP) and which Intel is

we've not seen a patch that actually works in this area unfortunately. 
We know Kristen's patch does work

> apparently now trying. That only saves around 250mW. Tejun's patch

.. and saves close to a watt on a laptop in our measurements

the patch is available on
http://www.kernel.org/pub/linux/kernel/people/kristen/patches/SATA/alpm/

maybe worth a try as well..
