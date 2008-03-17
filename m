From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] libata fixes
Date: Mon, 17 Mar 2008 19:31:55 +0100
Message-ID: <20080317183155.GA8667@elte.hu>
References: <20080317123524.GA22741@havoc.gtf.org> <20080317182905.GA8415@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41804 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbYCQScY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 14:32:24 -0400
Content-Disposition: inline
In-Reply-To: <20080317182905.GA8415@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>


changing CONFIG_ACPI_DOCK=m to CONFIG_ACPI_DOCK=y works around the build 
problem.

	Ingo
