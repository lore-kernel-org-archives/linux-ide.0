From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Wed, 28 Feb 2007 00:01:49 +0900
Message-ID: <45E447DD.9050308@gmail.com>
References: <45705618.2020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:14621 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbXB0PBu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 10:01:50 -0500
Received: by py-out-1112.google.com with SMTP id a29so900848pyi
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 07:01:50 -0800 (PST)
In-Reply-To: <45705618.2020608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Berck E. Nash wrote:
> Testing the new libata ICH PATA drivers.  There's one PATA port on this
> chip, and I've got two optical drives connected to it.  The master drive
> fails to detect.  The slave detects and works properly.

Can you test 2.6.20.1 and post full dmesg?

-- 
tejun
