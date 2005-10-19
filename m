From: hycsw@ca.sandia.gov (Helen Chen)
Subject: Re: sata_vsc.c
Date: Wed, 19 Oct 2005 12:37:41 -0700 (PDT)
Message-ID: <200510191937.MAA02973@ca.sandia.gov>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from california.sandia.gov ([146.246.250.1]:27660 "EHLO
	ca.sandia.gov") by vger.kernel.org with ESMTP id S1751247AbVJSTho
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Oct 2005 15:37:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: hycsw@ca.sandia.gov

Hi,

While building the kernel, we received warning that states omething
like : "pointer derived from interger without cast" in line 89 94 
of drivers/scsi/sata_vsc.c.  The kernel did terribale things to SATA
drives if the warning was ignored.

Helen
