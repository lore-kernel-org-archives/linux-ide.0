From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Mon, 1 Feb 2016 12:56:06 -0600
Message-ID: <56AFAA46.6090403@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <5730117.gx9ezcyLp7@wuerfel> <56A7A534.6040208@amd.com>
 <3904852.c3HykPsQQ2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3904852.c3HykPsQQ2@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Arnd,

On 01/29/2016 03:22 PM, Arnd Bergmann wrote:
> 
> For the ACPI case, I still think that an AML call from the AHCI driver
> is the most logical solution. You mentioned that you believe that calling
> into the AML interpreter up to 100 times per second is a noticeable
> overhead, but I doubt that and would like to see actual number backing
> that up. Note that most of the time, the status of the LEDs won't even
> change, so the driver does not have to call into the AML while I/O
> is in progress, or while it is stopped, only for the transition or in
> case of locate and fault events that should be extremely rare.
>
During disk activity ahci_sw_activity_blink() is called based on timer expiration (~100ms).
I just enabled the function profiler for 'dd if=/dev/zero of=/root/tmp bs=1M count=4096' and see the output below. The function was called 37 times in 2.5s
 
#echo 1 > function_profile_enabled

#dd if=/dev/zero of=/root/tempfile bs=1M count=4096
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 2.57334 s, 1.7 GB/s

#echo 0 > function_profile_enabled

#cat trace_stat/*
Function                               Hit    Time            Avg             s^2
--------                               ---    ----            ---             ---
seattle_transmit_led_message            37    25.088 us       0.678 us        0.050 us    

I am not debating on your AML call recommendation, it sounds like a good idea however BIOS is already released hence its bit late to add AML methods for this. I am seeking guidance on what can be done in the given situation. I thought platform driver is one option to get this feature enabled in kernel.

- Brijesh

> 	Arnd
> 
