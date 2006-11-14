From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] libata: change order of _SDD/_GTF execution (resend #3)
Date: Tue, 14 Nov 2006 14:19:17 -0500
Message-ID: <455A16B5.7040009@pobox.com>
References: <20060928182211.076258000@localhost.localdomain>	<20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>	<20060929021353.GB22082@srcf.ucam.org> <20061110161447.b4599cbd.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53704 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965940AbWKNTTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 14:19:30 -0500
In-Reply-To: <20061110161447.b4599cbd.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net, mjg59@srcf.ucam.org

Kristen Carlson Accardi wrote:
> Make the sdd call come before gtf.  _SDD is used to provide
> input to the _GTF file, so it should be executed first.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

applied


