From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [Bugme-new] [Bug 9533] New: 2.6.24-rc4: some ahci/acpi interaction
 causes delays during boot
Date: Mon, 10 Dec 2007 17:02:39 -0500
Message-ID: <475DB77F.9010709@redhat.com>
References: <bug-9533-10286@http.bugzilla.kernel.org/> <20071210125243.df6b441e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071210125243.df6b441e.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/10/2007 03:52 PM, Andrew Morton wrote:
> On Mon, 10 Dec 2007 05:55:20 -0800 (PST)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=9533
> 
> Another box-killing regression to track, please.  Either ATA or ACPI.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Quite possibly the BIOS is buggy and handed a bad taskfile to the driver.

