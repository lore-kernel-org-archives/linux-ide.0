From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Don't fail ata device revalidation for bad _GTF methods
Date: Sat, 10 Nov 2007 00:32:08 -0500
Message-ID: <47354258.30501@garzik.org>
References: <4731C86B.1040704@infracomspa.it> <20071107121355.5eaf4496.akpm@linux-foundation.org> <47333CCF.1050403@infracomspa.it> <20071108094958.5c9b1b22.akpm@linux-foundation.org> <20071108180256.GB3491@havoc.gtf.org> <20071108101341.6c4f88d4.akpm@linux-foundation.org> <20071108182217.GA2685@srcf.ucam.org> <20071108183707.GA3008@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071108183707.GA3008@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, roppedisano@infracomspa.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> Experience suggests that the _GTF method may be bad. We currently fail 
> device revalidation in that case, which seems excessive.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

applied


