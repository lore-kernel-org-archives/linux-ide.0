From: Linda Walsh <lkml@tlinx.org>
Subject: Re: SATA kernel-buffered read VERY slow (not raid, Promise TX300
 card); 2.6.23.1(vanilla)
Date: Sun, 06 Jan 2008 12:25:10 -0800
Message-ID: <47813926.6010908@tlinx.org>
References: <fa.o9uy6Qaq3PtHs2Z9lAKGUKvD85I@ifi.uio.no> <fa.1kDEq2SPE3FqpM5Mfw9CVGbvVdY@ifi.uio.no> <fa.hIZ5+XhGRugySB/HuLxr5qd6gAY@ifi.uio.no> <fa.iefWPg3R6g5Pnm/ktSCK9XWVFVw@ifi.uio.no> <fa.FhpaleM/osLTMJ85/PuxjxyJeGI@ifi.uio.no> <fa.MP5rgMp4TS2+Cfemd/uFOQOuquQ@ifi.uio.no> <477D9B6E.7060000@shaw.ca> <477D9D66.3080502@tlinx.org> <477DA05F.4080503@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:33484 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbYAFUZN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jan 2008 15:25:13 -0500
In-Reply-To: <477DA05F.4080503@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
>
> If this is a Seagate, I believe that they don't have AAM enabled on 
> any of their newer drives (something about a lawsuit for patent 
> infringement on that feature, or something). Quite likely they don't 
> support that power management command, either.
--
    Do you have a source for this -- haven't heard of such a conflict -- 
besides, doesn't
ATA-7 require some of those functions?  Given the trend toward 
power-saving and
quieter (also usually less vibration)  hard disks, I strongly disbelieve 
Seagate would
remove those features -- especially since they are mentioned on 
Seagate's drive
information page as being supported features.



