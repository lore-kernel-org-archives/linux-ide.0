From: "mike zheng" <mail4mz@gmail.com>
Subject: FIS structure and Command List structure for AHCI SATA controller
Date: Thu, 8 Nov 2007 22:38:25 -0500
Message-ID: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:56088 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344AbXKIDiZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 22:38:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so352727rvb
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2007 19:38:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi All,

I am working on an AHCI SATA controller. For each port, there is one
FIS descriptor and one Command List, which points to a Received FIS
structure and Command List structure. So what is Received FIS
structure? The Command List structure points to Command Table, that
has Command FIS field and Physical Region Descriptor table. I assume
the Command table is used for the communication between processor and
the SATA controller. Then why do we need the Received FIS structure?

Thanks for your help,

Mike
