From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Mon, 25 May 2009 09:11:10 +0100
Message-ID: <20090525091110.626da5f8@lxorguk.ukuu.org.uk>
References: <1229894315.6931.17.camel@Thutmosis>
	<494EDDBE.3010306@shaw.ca>
	<494F65C1.80602@kernel.org>
	<1229947998.6045.10.camel@Thutmosis>
	<49505500.8080409@kernel.org>
	<1230126055.6430.17.camel@Thutmosis>
	<495886E7.7050204@kernel.org>
	<1230586376.11130.46.camel@Thutmosis>
	<1231282276.6376.13.camel@Thutmosis>
	<49640CE1.6070808@kernel.org>
	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>
	<496483A5.6020105@kernel.org>
	<20090107105339.289f47a4@lxorguk.ukuu.org.uk>
	<49648C41.6030002@kernel.org>
	<4A1A0C1B.7020801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41476 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569AbZEYIMG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 04:12:06 -0400
In-Reply-To: <4A1A0C1B.7020801@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org, m.nov4k@gmail.com

On Mon, 25 May 2009 12:10:19 +0900
Tejun Heo <tj@kernel.org> wrote:

> Reviving an old thread and quoting whole body for new reporter.

I've not changed my view btw - which is that the quirk should match what
old IDE does here - issue the command and if it fails carry on regardless.


Alan
