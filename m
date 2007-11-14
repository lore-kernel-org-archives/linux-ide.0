From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: [Bugme-new] [Bug 9373] New: PDC20267 exception Emask on I/O
Date: Wed, 14 Nov 2007 02:57:00 +0100
Message-ID: <5501535d0711131757j3cd25c79k2a995a5a8ff146f2@mail.gmail.com>
References: <bug-9373-10286@http.bugzilla.kernel.org/>
	 <20071113170412.ffd94bba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:12617 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXKNB5C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 20:57:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so20682rvb
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 17:57:00 -0800 (PST)
In-Reply-To: <20071113170412.ffd94bba.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Are you sure?  Was the relevant driver not present in 2.6.23?

I never tried 2.6.23. 2.6.22 with PDC202XX_OLD worked fine. Than I tried to get
rid of the old ATA stuff and tried 2.6.22 with libata only and I got this
error, than I switched to 2.6.24-rc2 to see if the bug is in the dev. version.

regards
Bjoern Olausson
