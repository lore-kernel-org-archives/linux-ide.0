From: "A.E.Lawrence" <A.E.Lawrence@lboro.ac.uk>
Subject: Re: Primary ide disk inaccessible. 2.6.11.7, x86_64
Date: Sun, 24 Apr 2005 17:09:45 +0100
Message-ID: <426BC4C9.8060403@lboro.ac.uk>
References: <426B8D14.9050408@lboro.ac.uk> <064085cb719a246d17e19bde8dfcaee2@axiros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from weed.lut.ac.uk ([158.125.1.226]:53480 "EHLO weed.lut.ac.uk")
	by vger.kernel.org with ESMTP id S262351AbVDXQKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2005 12:10:43 -0400
In-Reply-To: <064085cb719a246d17e19bde8dfcaee2@axiros.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Egger <de@axiros.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Daniel Egger wrote:
> On 24.04.2005, at 14:12, A.E.Lawrence wrote:
> 
>> I have 4 sata, 1 scsi and 1 ata hard disks attached to an Asus A8N-SLI.
>> The primary ata disc (connected to ide0) is inaccessible:
> 
> 
> Are you booting from PATA or SATA?

Sata. And as I noted, it has worked booting from sata in one version of 
a 2.6.n kernel embedded in a debian install disk. Unless I am doing 
something stupid in the configuration, there seems to be a clear bug 
here to be tracked down.

ael
