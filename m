From: terry zheng <terryzheng0@gmail.com>
Subject: SATA AHCI driver question- how to enable SATA debug logging?
Date: Tue, 14 Jun 2011 23:52:59 +0800
Message-ID: <BANLkTin7px0rPzqKcjw9cfcYG27Cm-EaoA@mail.gmail.com>
References: <BANLkTi=qHOWDZcz-Y3fOcvgzt8HTfODtig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1FNPxA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2011 11:53:00 -0400
Received: by iwn34 with SMTP id 34so4758085iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2011 08:53:00 -0700 (PDT)
In-Reply-To: <BANLkTi=qHOWDZcz-Y3fOcvgzt8HTfODtig@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

We want to look into any debug data could be reported from the Linux
SATA AHCI driver, does anyone know how we get the SATA debug logging
enabled for SATA AHCI driver? Or any guideline how to configure kernel
config with debug enabled in the runtime? Appreciate anyone's help for
answering my questions. Below is kernel config we used:

Debian 5.0
Kernel:2.6.34.2 - x86_64



Thanks,

Terry
